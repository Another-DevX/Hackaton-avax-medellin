import {
  Form,
  FormControl,
  FormDescription,
  FormField,
  FormItem,
  FormLabel,
  FormMessage,
} from '@/components/ui/form';
import { useForm } from 'react-hook-form';
import { Input } from '@/components/ui/input';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Button } from '@/components/ui/button';

import { Tabs, TabsContent, TabsList, TabsTrigger } from '@/components/ui/tabs';
import { Popover, PopoverContent, PopoverTrigger } from '../ui/popover';

function WithFund() {
  const form = useForm();

  return (
    <Tabs defaultValue='fund'>
      <TabsList className='w-full'>
        <TabsTrigger value='fund' className='w-full'>
          Fund Account
        </TabsTrigger>
        <TabsTrigger className='w-full' value='withdraw'>
          Withdraw
        </TabsTrigger>
      </TabsList>
      <TabsContent value='fund'>
        <Form {...form}>
          <FormField
            control={form.control}
            name='token'
            render={({ field }) => (
              <FormItem>
                <FormLabel>Token</FormLabel>
                <FormControl>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder='Token' />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value='0x...'>USDT</SelectItem>
                      <SelectItem value='0x.11'>USDC</SelectItem>
                    </SelectContent>
                  </Select>
                </FormControl>
                <FormDescription>
                  Select the token you want to fund your account with.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name='amount'
            render={({ field }) => (
              <FormItem>
                <FormLabel>Amount</FormLabel>
                <FormControl>
                  <Input placeholder='Amount' {...field} />
                </FormControl>
                <FormDescription>
                  Enter the amount you want to fund your account with.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />
          <div className='w-full flex flex-row gap-2 my-4'>
            <FormField
              control={form.control}
              name='amount'
              render={({ field }) => (
                <FormItem>
                  <FormControl>
                    <Button className='w-full'>Submit</Button>
                  </FormControl>
                  <FormMessage />
                </FormItem>
              )}
            />
            <Popover>
              <PopoverTrigger>
                <Button variant='outline' className='w-full'>
                  Approve Spendance
                </Button>
              </PopoverTrigger>
              <PopoverContent>
                <Form {...form}>
                  <FormField
                    control={form.control}
                    name='token'
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Token</FormLabel>
                        <FormControl>
                          <Select>
                            <SelectTrigger>
                              <SelectValue placeholder='Token' />
                            </SelectTrigger>
                            <SelectContent>
                              <SelectItem value='0x...'>USDT</SelectItem>
                              <SelectItem value='0x.11'>USDC</SelectItem>
                            </SelectContent>
                          </Select>
                        </FormControl>
                        <FormDescription>
                          Select the token you want to approve spendance.
                        </FormDescription>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <FormField
                    control={form.control}
                    name='amount'
                    render={({ field }) => (
                      <FormItem>
                        <FormLabel>Amount</FormLabel>
                        <FormControl>
                          <Input placeholder='Amount' {...field} />
                        </FormControl>
                        <FormDescription>
                          Enter the amount you want to approve spendance.
                        </FormDescription>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                  <FormField
                    control={form.control}
                    name='amount'
                    render={({ field }) => (
                      <FormItem>
                        <FormControl>
                          <Button className='my-5 w-full'>Approve</Button>
                        </FormControl>
                        <FormMessage />
                      </FormItem>
                    )}
                  />
                </Form>
              </PopoverContent>
            </Popover>
          </div>
        </Form>
      </TabsContent>
      <TabsContent value='withdraw'>
        <Form {...form}>
          <FormField
            control={form.control}
            name='token'
            render={({ field }) => (
              <FormItem>
                <FormLabel>Token</FormLabel>
                <FormControl>
                  <Select>
                    <SelectTrigger>
                      <SelectValue placeholder='Token' />
                    </SelectTrigger>
                    <SelectContent>
                      <SelectItem value='0x...'>USDT</SelectItem>
                      <SelectItem value='0x.11'>USDC</SelectItem>
                    </SelectContent>
                  </Select>
                </FormControl>
                <FormDescription>
                  Select the token you want to withdraw from your account.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name='amount'
            render={({ field }) => (
              <FormItem>
                <FormLabel>Amount</FormLabel>
                <FormControl>
                  <Input placeholder='Amount' {...field} />
                </FormControl>
                <FormDescription>
                  Enter the amount you want to withdraw from your account.
                </FormDescription>
                <FormMessage />
              </FormItem>
            )}
          />
          <FormField
            control={form.control}
            name='amount'
            render={({ field }) => (
              <FormItem>
                <FormControl>
                  <Button className='my-5 w-full'>Submit</Button>
                </FormControl>
                <FormMessage />
              </FormItem>
            )}
          />
        </Form>
      </TabsContent>
    </Tabs>
  );
}

export default WithFund;
